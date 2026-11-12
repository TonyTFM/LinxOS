#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

#define PORT 8080

struct GameState {
    int metall = 500;
    int kristall = 300;
    int luth = 150;
    int energie = 100;
    int haeuser_lvl = 1;
    int metallmine_lvl = 1;
    int kristall_lvl = 1;
    int bio_raffinerie = 1;
    int werft_lvl = 1;
    int jaeger = 4;
    int kreuzer = 1;
    int sektoren_erobert = 1;
    int tick = 1;
    std::vector<std::string> log = {"[Dschungel-HQ]: Landung im Sektor Alpha-7 erfolgreich."};
};

GameState g;

void add_log(const std::string& msg) {
    g.log.insert(g.log.begin(), msg);
    if (g.log.size() > 8) g.log.pop_back();
}

std::string render_page() {
    std::string log_html = "";
    for (const auto& entry : g.log) log_html += "<li>" + entry + "</li>";

    int kolonie_pop = g.haeuser_lvl * 25;
    int prod_metall = g.metallmine_lvl * 60;
    int prod_kristall = g.kristall_lvl * 40;
    int prod_luth = g.bio_raffinerie * 30;

    return "<html><head><meta charset='UTF-8'><style>"
           "body { background: #07130b; color: #a3e635; font-family: monospace; padding: 20px; }"
           "h1 { color: #4ade80; border-bottom: 2px solid #14532d; padding-bottom: 8px; }"
           "h3 { color: #86efac; margin-top: 0; }"
           ".grid { display: flex; gap: 15px; flex-wrap: wrap; }"
           ".card { background: #0d2215; border: 1px solid #166534; padding: 15px; border-radius: 8px; flex: 1; min-width: 280px; }"
           "button { background: #15803d; color: #f0fdf4; border: 1px solid #22c55e; padding: 8px 12px; border-radius: 4px; cursor: pointer; font-family: monospace; margin: 4px 2px; }"
           "button:hover { background: #16a34a; }"
           ".atk { background: #991b1b; border-color: #ef4444; }"
           ".atk:hover { background: #b91c1c; }"
           "ul { color: #bbf7d0; padding-left: 18px; }"
           "</style></head><body>"
           "<h1>🌴 LinxOS: Dschungel-Conquest — Zyklus " + std::to_string(g.tick) + "</h1>"
           "<div class='grid'>"
           "<div class='card'>"
           "<h3>📦 Lagerbestände</h3>"
           "<p>🔩 Metall: <b>" + std::to_string(g.metall) + "</b> (+" + std::to_string(prod_metall) + "/Zyklus)</p>"
           "<p>💎 Kristall: <b>" + std::to_string(g.kristall) + "</b> (+" + std::to_string(prod_kristall) + "/Zyklus)</p>"
           "<p>⛽ Bio-Luth: <b>" + std::to_string(g.luth) + "</b> (+" + std::to_string(prod_luth) + "/Zyklus)</p>"
           "<p>👥 Kolonisten (Häuser): <b>" + std::to_string(kolonie_pop) + "</b> | 🗺️ Sektoren: <b>" + std::to_string(g.sektoren_erobert) + "</b></p>"
           "</div>"
           "<div class='card'>"
           "<h3>🏗️ Dschungel-Gebäude</h3>"
           "<form action='/up_haus' method='GET'><button>🏠 Wohn-Kuppel Lvl " + std::to_string(g.haeuser_lvl) + " (100M, 50K)</button></form>"
           "<form action='/up_metall' method='GET'><button>⛏️ Metallmine Lvl " + std::to_string(g.metallmine_lvl) + " (120M, 40K)</button></form>"
           "<form action='/up_kristall' method='GET'><button>💎 Kristall-Höhle Lvl " + std::to_string(g.kristall_lvl) + " (150M, 80K)</button></form>"
           "<form action='/up_luth' method='GET'><button>🌿 Bio-Raffinerie Lvl " + std::to_string(g.bio_raffinerie) + " (200M, 100K)</button></form>"
           "</div>"
           "<div class='card'>"
           "<h3>🚀 Werft & Eroberung</h3>"
           "<p>Flotte: <b>" + std::to_string(g.jaeger) + " Jäger</b> | <b>" + std::to_string(g.kreuzer) + " Kreuzer</b></p>"
           "<form action='/build_jaeger' method='GET'><button>🛸 Jäger bauen (150M, 50K)</button></form>"
           "<form action='/build_kreuzer' method='GET'><button>🚀 Kreuzer bauen (400M, 200K, 50L)</button></form>"
           "<form action='/conquer' method='GET'><button class='atk'>⚔️ Dschungel erobern (80 Luth)</button></form>"
           "<form action='/tick' method='GET'><button>⏳ Nächster Zyklus</button></form>"
           "</div></div>"
           "<div class='card' style='margin-top:15px;'>"
           "<h3>📡 Protokoll</h3><ul>" + log_html + "</ul>"
           "</div></body></html>";
}

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1, addrlen = sizeof(address);

    server_fd = socket(AF_INET, SOCK_STREAM, 0);
    setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);
    bind(server_fd, (struct sockaddr *)&address, sizeof(address));
    listen(server_fd, 10);

    std::cout << "[+] Dschungel-Server aktiv auf http://127.0.0.1:8080\n";

    while(true) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) continue;
        char buffer[2048] = {0};
        read(new_socket, buffer, 2048);
        std::string req(buffer);

        if (req.find("GET /up_haus") != std::string::npos) {
            if (g.metall >= 100 && g.kristall >= 50) { g.metall -= 100; g.kristall -= 50; g.haeuser_lvl++; add_log("🏠 Wohn-Kuppel ausgebaut!"); }
            else add_log("❌ Zu wenig Rohstoffe für Häuser.");
        } else if (req.find("GET /up_metall") != std::string::npos) {
            if (g.metall >= 120 && g.kristall >= 40) { g.metall -= 120; g.kristall -= 40; g.metallmine_lvl++; add_log("⛏️ Metallmine ausgebaut!"); }
            else add_log("❌ Zu wenig Rohstoffe für Metallmine.");
        } else if (req.find("GET /up_kristall") != std::string::npos) {
            if (g.metall >= 150 && g.kristall >= 80) { g.metall -= 150; g.kristall -= 80; g.kristall_lvl++; add_log("💎 Kristall-Höhle ausgebaut!"); }
            else add_log("❌ Zu wenig Rohstoffe für Kristall-Höhle.");
        } else if (req.find("GET /up_luth") != std::string::npos) {
            if (g.metall >= 200 && g.kristall >= 100) { g.metall -= 200; g.kristall -= 100; g.bio_raffinerie++; add_log("🌿 Bio-Raffinerie ausgebaut!"); }
            else add_log("❌ Zu wenig Rohstoffe für Raffinerie.");
        } else if (req.find("GET /build_jaeger") != std::string::npos) {
            if (g.metall >= 150 && g.kristall >= 50) { g.metall -= 150; g.kristall -= 50; g.jaeger++; add_log("🛸 Jäger gebaut!"); }
            else add_log("❌ Zu wenig Rohstoffe für Jäger.");
        } else if (req.find("GET /build_kreuzer") != std::string::npos) {
            if (g.metall >= 400 && g.kristall >= 200 && g.luth >= 50) { g.metall -= 400; g.kristall -= 200; g.luth -= 50; g.kreuzer++; add_log("🚀 Kreuzer gebaut!"); }
            else add_log("❌ Zu wenig Rohstoffe für Kreuzer.");
        } else if (req.find("GET /conquer") != std::string::npos) {
            int flotten_kraft = (g.jaeger * 10) + (g.kreuzer * 50) + (g.haeuser_lvl * 15);
            int feind_kraft = g.sektoren_erobert * 85;
            if (g.luth < 80) { add_log("❌ Nicht genug Bio-Luth (80 benötigt)!"); }
            else if (flotten_kraft >= feind_kraft) {
                g.luth -= 80; g.sektoren_erobert++;
                int bm = g.sektoren_erobert * 250, bk = g.sektoren_erobert * 150;
                g.metall += bm; g.kristall += bk;
                add_log("⚔️ Sektor erobert! +Beute!");
            } else { g.luth -= 80; add_log("💥 Angriff fehlgeschlagen! Flotte zu schwach."); }
        } else if (req.find("GET /tick") != std::string::npos) {
            g.tick++;
            g.metall += (g.metallmine_lvl * 60) * g.sektoren_erobert;
            g.kristall += (g.kristall_lvl * 40) * g.sektoren_erobert;
            g.luth += (g.bio_raffinerie * 30);
            add_log("⏳ Zyklus " + std::to_string(g.tick) + " abgeschlossen.");
        }

        std::string body = render_page();
        std::string resp = "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\nContent-Length: " + std::to_string(body.length()) + "\r\n\r\n" + body;
        write(new_socket, resp.c_str(), resp.length());
        close(new_socket);
    }
    return 0;
}
