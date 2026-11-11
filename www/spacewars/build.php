<?php
header('Content-Type: application/json');

$dbPath = __DIR__ . '/spacewars.db';
$db = new SQLite3($dbPath);

// Tabellen sicherstellen
$db->exec("CREATE TABLE IF NOT EXISTS player (id INTEGER PRIMARY KEY, metal INT, crystal INT, deuterium INT);");
$db->exec("CREATE TABLE IF NOT EXISTS buildings (name TEXT PRIMARY KEY, level INT);");
$db->exec("CREATE TABLE IF NOT EXISTS ships (name TEXT PRIMARY KEY, count INT);");
$db->exec("CREATE TABLE IF NOT EXISTS defense (name TEXT PRIMARY KEY, count INT);");

$input = json_decode(file_get_contents('php://input'), true);
$action =$input['action'] ?? '';
$target =$input['target'] ?? '';

if ($action === 'upgrade_building') {$allowedBuildings = [
        'metal_mine', 'crystal_mine', 'solar_plant', 
        'deuterium_synthesizer', 'shipyard', 'heavy_factory', 
        'nanite_factory', 'mine_housing', 'construction_plant'
    ];
    
    if (!in_array($target,$allowedBuildings)) {
        echo json_encode(['success' => false, 'error' => 'Unbekanntes Gebäude']);
        exit;
    }

    $db->exec("INSERT OR IGNORE INTO buildings (name, level) VALUES ('$target', 0);");
    $db->exec("UPDATE buildings SET level = level + 1 WHERE name = '$target'");
    $newLevel =$db->querySingle("SELECT level FROM buildings WHERE name = '$target'");

    echo json_encode(['success' => true, 'type' => 'building', 'target' => $target, 'new_level' =>$newLevel]);
    exit;
} 
elseif ($action === 'build_ship') {$allowedShips = ['light_fighter', 'heavy_fighter', 'small_cargo', 'large_cargo', 'cruiser', 'battleship'];
    if (!in_array($target,$allowedShips)) {
        echo json_encode(['success' => false, 'error' => 'Unbekannter Schiffstyp']);
        exit;
    }

    $shipyardLevel =$db->querySingle("SELECT level FROM buildings WHERE name = 'shipyard'") ?? 0;
    if ($shipyardLevel < 1) {
        echo json_encode(['success' => false, 'error' => 'Schiffswerft erforderlich!']);
        exit;
    }

    $db->exec("INSERT OR IGNORE INTO ships (name, count) VALUES ('$target', 0);");
    $db->exec("UPDATE ships SET count = count + 5 WHERE name = '$target'");
    $newCount =$db->querySingle("SELECT count FROM ships WHERE name = '$target'");

    echo json_encode(['success' => true, 'type' => 'ship', 'target' => $target, 'new_count' =>$newCount]);
    exit;
}
elseif ($action === 'build_defense') {$allowedDefenses = ['rocket_launcher', 'light_laser', 'heavy_laser', 'gauss_cannon', 'plasma_turret'];
    if (!in_array($target,$allowedDefenses)) {
        echo json_encode(['success' => false, 'error' => 'Unbekannte Verteidigungsanlage']);
        exit;
    }

    $shipyardLevel =$db->querySingle("SELECT level FROM buildings WHERE name = 'shipyard'") ?? 0;
    if ($shipyardLevel < 1) {
        echo json_encode(['success' => false, 'error' => 'Schiffswerft / Basis für Rüstung erforderlich!']);
        exit;
    }

    $db->exec("INSERT OR IGNORE INTO defense (name, count) VALUES ('$target', 0);");
    $db->exec("UPDATE defense SET count = count + 5 WHERE name = '$target'"); // Direkt 5er-Packs
    $newCount =$db->querySingle("SELECT count FROM defense WHERE name = '$target'");

    echo json_encode(['success' => true, 'type' => 'defense', 'target' => $target, 'new_count' =>$newCount]);
    exit;
}

echo json_encode(['success' => false, 'error' => 'Ungültige Aktion']);
// Großer Transporter Unterstützung im Backend
// (Bereits in der Erlaubnisliste enthalten, wird hier durchgereicht)
