#!/bin/bash
while true; do
  clear
  echo "=========================================="
  echo "   🚀 JUSTUS PI-CONTROL-CENTER v1.1 🚀   "
  echo "=========================================="
  echo "1) Pi-hole Status prüfen (Grün/Rot?)"
  echo "2) Live-Matrix starten (DNS Log)"
  echo "3) Bild.de & Speedtest freischalten"
  echo "4) Internet-Wachhund (Skript) manuell testen"
  echo "5) System-Update (Neutrinos jagen)"
  echo "6) 🤖 KI-FIREWALL & HARDWARE-TUNING (GOD MODE)"
  echo "7) Beenden"
  echo "=========================================="
  read -p "Was willst du tun, Boss? (1-7): " choice

  case $choice in
    1) 
       sudo pihole status
       read -p "Enter drücken zum Zurückkehren..." ;;
    2) 
       sudo pihole -t
       ;;
    3) 
       sudo pihole -w bild.de www.bild.de speedtest.net www.speedtest.net
       echo "Seiten wurden auf die Whitelist gesetzt! ✅"
       sleep 2 ;;
    4) 
       /home/justin/reconnect.sh
       read -p "Wachhund-Test fertig. Enter drücken..." ;;
    5) 
       sudo pihole -up
       read -p "System ist auf dem neuesten Stand. Enter..." ;;
    6) 
       echo "--- Optimiere Hardware (Governor & Network) ---"
       # Verhindert, dass Justin runtertaktet (maximale Leistung)
       echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
       # Vergrößert die Puffer für den Netzwerkverkehr
       sudo sysctl -w net.core.rmem_max=2500000
       sudo sysctl -w net.core.wmem_max=2500000
       
       echo "--- KI-FIREWALL WIRD SCHARF GESCHALTET ---"
       echo "--- (Drücke Strg+C zum Beenden) ---"
       
       # Scannt das Log live nach verdächtigem JavaScript-Verhalten
       sudo tail -f /var/log/pihole/FTL.log | while read line; do
         if [[ $line == *"eval("* ]] || [[ $line == *"unescape("* ]]; then
            domain=$(echo $line | awk '{print $4}')
            echo "[!] KI-ALARM: $domain wegen JS-Pattern geblockt! 🛡️"
            sudo pihole -b $domain
         fi
       done
       ;;
    7) 
       echo "Hau rein, Justus! Dein Imperium läuft weiter. 🤘"
       exit ;;
    *) 
       echo "Ungültige Wahl, du Genie! 🤣🤣🤣"
       sleep 1 ;;
  esac
done
