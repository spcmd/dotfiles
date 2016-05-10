#!/usr/bin/env dash

acpi_path="/usr/sbin/acpi"

if [ ! -e "$acpi_path" ]; then
    echo "Error: $acpi_path doesn't exist. Is acpi package installed?"
    exit 1
fi

case $1 in
    timeleft) acpi -b | awk '{print $(NF-1)}' ;;
    state) acpi -b | awk '{sub(",","",$3);print $3}' ;;
    capacity) acpi -b | awk '{sub(",","",$4);print $4}' ;;
esac
