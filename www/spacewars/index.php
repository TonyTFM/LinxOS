<?php
// LinxOS SpaceWars Dashboard - Retro OGame Style
session_start();

$dbPath = __DIR__ . '/spacewars.db';
$db = new SQLite3($dbPath);

// Tabellen initialisieren
$db->exec("CREATE TABLE IF NOT EXISTS player (id INTEGER PRIMARY KEY, metal INT, crystal INT, deuterium INT);");
$db->exec("CREATE TABLE IF NOT EXISTS buildings (name TEXT PRIMARY KEY, level INT);");
$db->exec("CREATE TABLE IF NOT EXISTS ships (name TEXT PRIMARY KEY, count INT);");
$db->exec("CREATE TABLE IF NOT EXISTS defense (name TEXT PRIMARY KEY, count INT);");

// Standardwerte Player
$resCheck = $db->querySingle("SELECT COUNT(*) FROM player");
if ($resCheck == 0) {
    $db->exec("INSERT INTO player (id, metal, crystal, deuterium) VALUES (1, 2500, 1200, 500);");
}

// Standardwerte Gebäude
$defaultsBld = [
    'metal_mine' => 1, 'crystal_mine' => 1, 'solar_plant' => 2, 
    'deuterium_synthesizer' => 1, 'shipyard' => 1, 'heavy_factory' => 0,
    'nanite_factory' => 0, 'mine_housing' => 0, 'construction_plant' => 1
];
foreach ($defaultsBld as $b => $lvl) {
    $db->exec("INSERT OR IGNORE INTO buildings (name, level) VALUES ('$b', $lvl);");
}

// Standardwerte Schiffe
$defaultsShips = ['light_fighter' => 5, 'small_cargo' => 20, 'heavy_fighter' => 0, 'cruiser' => 0, 'battleship' => 0];
foreach ($defaultsShips as $s => $cnt) {
    $db->exec("INSERT OR IGNORE INTO ships (name, count) VALUES ('$s', $cnt);");
}

// Standardwerte Verteidigung
$defaultsDef = ['rocket_launcher' => 0, 'light_laser' => 0, 'heavy_laser' => 0, 'gauss_cannon' => 0, 'plasma_turret' => 0];
foreach ($defaultsDef as $d => $cnt) {
    $db->exec("INSERT OR IGNORE INTO defense (name, count) VALUES ('$d', $cnt);");
}

// Daten laden
$player = $db->querySingle("SELECT metal, crystal, deuterium FROM player WHERE id = 1", true);

$buildingsResult = $db->query("SELECT name, level FROM buildings");
$buildings = [];
while ($row = $buildingsResult->fetchArray(SQLITE3_ASSOC)) {
    $buildings[$row['name']] = $row['level'];
}

$shipsResult = $db->query("SELECT name, count FROM ships");
$ships = [];
while ($row = $shipsResult->fetchArray(SQLITE3_ASSOC)) {
    $ships[$row['name']] = $row['count'];
}

$defResult = $db->query("SELECT name, count FROM defense");
$defenses = [];
while ($row = $defResult->fetchArray(SQLITE3_ASSOC)) {
    $defenses[$row['name']] = $row['count'];
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpaceWars // LinxOS Command Center</title>
    <style>
        body {
            background-color: #0d1117;
            color: #c9d1d9;
            font-family: 'Courier New', Courier, monospace;
            margin: 0;
            padding: 15px;
        }
        .container {
            max-width: 650px;
            margin: 0 auto;
            background-color: #161b22;
            border: 1px solid #30363d;
            border-radius: 6px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
        }
        h1 {
            color: #58a6ff;
            font-size: 1.3em;
            border-bottom: 1px solid #30363d;
            padding-bottom: 10px;
            margin-top: 0;
        }
        .resources {
            display: flex;
            justify-content: space-between;
            background-color: #21262d;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 0.95em;
            border: 1px solid #30363d;
        }
        .res-metal { color: #f0883e; }
        .res-crystal { color: #58a6ff; }
        .res-deuterium { color: #3fb950; }
        
        h2 {
            font-size: 1.1em;
            color: #8b949e;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 25px;
        }
        .building-card, .ship-card, .def-card {
            background-color: #21262d;
            border: 1px solid #30363d;
            padding: 12px 15px;
            margin-bottom: 10px;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .building-info span, .ship-info span, .def-info span {
            color: #8b949e;
            font-size: 0.85em;
        }
        button {
            background-color: #238636;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 4px;
            cursor: pointer;
            font-family: monospace;
            font-weight: bold;
        }
        button:hover {
            background-color: #2ea043;
        }
        .btn-ship { background-color: #1f6feb; }
        .btn-ship:hover { background-color: #388bfd; }
        .btn-heavy { background-color: #8957e5; }
        .btn-heavy:hover { background-color: #a371f7; }
        .btn-def { background-color: #d29922; color: #0d1117; }
        .btn-def:hover { background-color: #e3b341; }
        .btn-tech { background-color: #da3633; }
        .btn-tech:hover { background-color: #f85149; }
        .footer {
            margin-top: 25px;
            font-size: 0.75em;
            color: #8b949e;
            text-align: center;
            border-top: 1px solid #30363d;
            padding-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🌌 SpaceWars // Command Center [Apex-Prime 20:7:5:50]</h1>
        
        <div class="resources">
            <div>M: <span class="res-metal"><?= number_format($player['metal']) ?></span></div>
            <div>K: <span class="res-crystal"><?= number_format($player['crystal']) ?></span></div>
            <div>D (Luth): <span class="res-deuterium"><?= number_format($player['deuterium']) ?></span></div>
        </div>

        <h2>🏗️ Infrastruktur & Hightech-Anlagen</h2>
        
        <div class="building-card">
            <div class="building-info">
                <strong>Metallmine</strong> (Stufe <span id="lvl-metal_mine"><?= $buildings['metal_mine'] ?? 1 ?></span>)
            </div>
            <button onclick="upgradeBuilding('metal_mine')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Kristallmine</strong> (Stufe <span id="lvl-crystal_mine"><?= $buildings['crystal_mine'] ?? 1 ?></span>)
            </div>
            <button onclick="upgradeBuilding('crystal_mine')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Solarkraftwerk</strong> (Stufe <span id="lvl-solar_plant"><?= $buildings['solar_plant'] ?? 1 ?></span>)
            </div>
            <button onclick="upgradeBuilding('solar_plant')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Deuteriumsynthesizer (Luth)</strong> (Stufe <span id="lvl-deuterium_synthesizer"><?= $buildings['deuterium_synthesizer'] ?? 1 ?></span>)
            </div>
            <button onclick="upgradeBuilding('deuterium_synthesizer')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Minenhäuser (Quartiere)</strong> (Stufe <span id="lvl-mine_housing"><?= $buildings['mine_housing'] ?? 0 ?></span>)
            </div>
            <button onclick="upgradeBuilding('mine_housing')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Schiffswerft</strong> (Stufe <span id="lvl-shipyard"><?= $buildings['shipyard'] ?? 1 ?></span>)
            </div>
            <button onclick="upgradeBuilding('shipyard')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Schwere Fabrik</strong> (Stufe <span id="lvl-heavy_factory"><?= $buildings['heavy_factory'] ?? 0 ?></span>)
            </div>
            <button class="btn-heavy" onclick="upgradeBuilding('heavy_factory')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Nanitenfabrik</strong> (Stufe <span id="lvl-nanite_factory"><?= $buildings['nanite_factory'] ?? 0 ?></span>)
            </div>
            <button class="btn-tech" onclick="upgradeBuilding('nanite_factory')">Ausbauen</button>
        </div>

        <div class="building-card">
            <div class="building-info">
                <strong>Bauanlage (Baulisten-Zentrale)</strong> (Stufe <span id="lvl-construction_plant"><?= $buildings['construction_plant'] ?? 1 ?></span>)
            </div>
            <button onclick="upgradeBuilding('construction_plant')">Ausbauen</button>
        </div>

        <h2>🚀 Flotte & Großkampfschiffe</h2>

        <div class="ship-card">
            <div class="ship-info">
                <strong>Leichter Jäger</strong> (Anzahl: <span id="ship-light_fighter"><?= $ships['light_fighter'] ?? 0 ?></span>)
            </div>
            <button class="btn-ship" onclick="buildShip('light_fighter')">+5 Bau</button>
        </div>

        <div class="ship-card">
            <div class="ship-info">
                <strong>Kleiner Transporter</strong> (Anzahl: <span id="ship-small_cargo"><?= $ships['small_cargo'] ?? 0 ?></span>)
            </div>
            <button class="btn-ship" onclick="buildShip('small_cargo')">+5 Bau</button>
        </div>

        <div class="ship-card">
            <div class="ship-info">
                <strong>Kreuzer (Cougers)</strong> (Anzahl: <span id="ship-cruiser"><?= $ships['cruiser'] ?? 0 ?></span>)
            </div>
            <button class="btn-heavy" onclick="buildShip('cruiser')">+5 Bau</button>
        </div>

        <div class="ship-card">
            <div class="ship-info">
                <strong>Schweres Schlachtschiff</strong> (Anzahl: <span id="ship-battleship"><?= $ships['battleship'] ?? 0 ?></span>)
            </div>
            <button class="btn-heavy" onclick="buildShip('battleship')">+5 Bau</button>
        </div>

        <h2>🛡️ Sektor-Verteidigung</h2>

        <div class="def-card">
            <div class="def-info">
                <strong>Raketenwerfer</strong> (Anzahl: <span id="def-rocket_launcher"><?= $defenses['rocket_launcher'] ?? 0 ?></span>)
            </div>
            <button class="btn-def" onclick="buildDefense('rocket_launcher')">+5 Bau</button>
        </div>

        <div class="def-card">
            <div class="def-info">
                <strong>Leichter Laser</strong> (Anzahl: <span id="def-light_laser"><?= $defenses['light_laser'] ?? 0 ?></span>)
            </div>
            <button class="btn-def" onclick="buildDefense('light_laser')">+5 Bau</button>
        </div>

        <div class="def-card">
            <div class="def-info">
                <strong>Schwerer Laser</strong> (Anzahl: <span id="def-heavy_laser"><?= $defenses['heavy_laser'] ?? 0 ?></span>)
            </div>
            <button class="btn-def" onclick="buildDefense('heavy_laser')">+5 Bau</button>
        </div>

        <div class="def-card">
            <div class="def-info">
                <strong>Gauss-Kanone</strong> (Anzahl: <span id="def-gauss_cannon"><?= $defenses['gauss_cannon'] ?? 0 ?></span>)
            </div>
            <button class="btn-def" onclick="buildDefense('gauss_cannon')">+5 Bau</button>
        </div>

        <div class="def-card">
            <div class="def-info">
                <strong>Plasma-Turm</strong> (Anzahl: <span id="def-plasma_turret"><?= $defenses['plasma_turret'] ?? 0 ?></span>)
            </div>
            <button class="btn-def" onclick="buildDefense('plasma_turret')">+5 Bau</button>
        </div>

        <div class="footer">
            LinxOS v1.1.0 // Authenticated as GN9@Apex
        </div>
    </div>

    <script>
    function upgradeBuilding(buildingKey) {
        fetch('build.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action: 'upgrade_building', target: buildingKey })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('lvl-' + data.target).innerText = data.new_level;
            } else {
                alert('Fehler: ' + (data.error || 'Unbekannt'));
            }
        });
    }

    function buildShip(shipKey) {
        fetch('build.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action: 'build_ship', target: shipKey })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('ship-' + data.target).innerText = data.new_count;
            } else {
                alert('Fehler: ' + (data.error || 'Unbekannt'));
            }
        });
    }

    function buildDefense(defKey) {
        fetch('build.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action: 'build_defense', target: defKey })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('def-' + data.target).innerText = data.new_count;
            } else {
                alert('Fehler: ' + (data.error || 'Unbekannt'));
            }
        });
    }
    </script>
</body>
</html>
