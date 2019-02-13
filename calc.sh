#!/bin/bash
# Warten auf das richtige Ergebnis.

echo "Frage: Was ergibt 2 + 2"
echo ""
while true
  do
    read -p "Bitte ihre Eingabe:" answer
    case "$answer" in
      4) echo richtig
          break
          ;;
      *) echo falsch
          ;;
    esac
done

