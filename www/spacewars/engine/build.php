<?php
// Beispielhafte Absicherung für die Aktion
$action = $_REQUEST['action'] ?? '';

if (empty($action)) {
    echo json_encode(["success" => false, "error" => "Ungültige Aktion"]);
    exit;
}


<?php
// LinxOS v1.1.0 - SpaceWars Building & Upgrade Engine

header('Content-Type: application/json');

function calculateBuildingCosts($buildingKey, $currentLevel) {
    $config = json_decode(file_get_contents(__DIR__ . '/../config/buildings.json'), true);
    
    if (!isset($config[$buildingKey])) {
        return ['error' => 'Building not found'];
    }
    
    $b = $config[$buildingKey];
    $factor = $b['factor'];
    
    // Kostenformel: Basis * (Factor ^ Level)
    $metal = round($b['base_metal'] * pow($factor, $currentLevel));
    $crystal = round($b['base_crystal'] * pow($factor, $currentLevel));
    $deuterium = isset($b['base_deuterium']) ? round($b['base_deuterium'] * pow($factor, $currentLevel)) : 0;
    
    // Bauzeit in Sekunden: (Metall + Kristall) / (2500 * (1 + Roboterstufe) * (2 ^ Nanitenstufe))
    // Vereinfacht für den Start
    $baseSeconds = (($metal + $crystal) / 2500) * 3600;
    
    return [
        'building' => $b['name'],
        'next_level' => $currentLevel + 1,
        'cost' => [
            'metal' => $metal,
            'crystal' => $crystal,
            'deuterium' => $deuterium
        ],
        'build_time_seconds' => max(1, round($baseSeconds))
    ];
}

function processUpgrade(&$playerResources, $buildingKey, &$playerBuildings) {
    $currentLevel = isset($playerBuildings[$buildingKey]) ? $playerBuildings[$buildingKey] : 0;
    $requirements = calculateBuildingCosts($buildingKey, $currentLevel);
    
    if (isset($requirements['error'])) {
        return ['success' => false, 'message' => $requirements['error']];
    }
    
    $cost = $requirements['cost'];
    
    // Prüfen ob genug Rohstoffe da sind
    if ($playerResources['metal'] >= $cost['metal'] && 
        $playerResources['crystal'] >= $cost['crystal'] && 
        $playerResources['deuterium'] >= $cost['deuterium']) {
        
        // Rohstoffe abziehen
        $playerResources['metal'] -= $cost['metal'];
        $playerResources['crystal'] -= $cost['crystal'];
        $playerResources['deuterium'] -= $cost['deuterium'];
        
        // Gebäude-Level erhöhen
        $playerBuildings[$buildingKey] = $currentLevel + 1;
        
        return [
            'success' => true,
            'message' => 'Upgrade erfolgreich auf Stufe ' . $playerBuildings[$buildingKey],
            'remaining_resources' => $playerResources,
            'building_levels' => $playerBuildings
        ];
    } else {
        return [
            'success' => false,
            'message' => 'Nicht genügend Rohstoffe vorhanden!'
        ];
    }
}

// Test-Simulation bei direktem Aufruf
if (basename(__FILE__) == basename($_SERVER['SCRIPT_FILENAME'])) {
    $simResources = ['metal' => 1000, 'crystal' => 500, 'deuterium' => 200];
    $simBuildings = ['metal_mine' => 1];
    
    echo "--- Kosten für Stufe 2 Metallmine ---\n";
    echo json_encode(calculateBuildingCosts('metal_mine', 1), JSON_PRETTY_PRINT) . "\n\n";
    
    echo "--- Versuch Upgrade durchzuführen ---\n";
    echo json_encode(processUpgrade($simResources, 'metal_mine', $simBuildings), JSON_PRETTY_PRINT);
}
