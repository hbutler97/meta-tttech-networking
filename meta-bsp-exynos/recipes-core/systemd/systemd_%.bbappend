FILESEXTRAPATHS_prepend:="${THISDIR}/files:"

# It is necessary to enable also 'systemd-sysusers' service in order
# to add 'systemd-network' user and avoid having errors when 
# 'systemd-tmpfiles-setup' service is executed.
PACKAGECONFIG += "networkd sysusers"
PACKAGECONFIG[networkd] = "--enable-networkd,--disable-networkd"
PACKAGECONFIG[sysusers] = "--enable-sysusers,--disable-sysusers"

SRC_URI += " file://pcie.network \
             file://pcie.link \
           "
FILES_${PN} += "{sysconfdir}/systemd/network/*"

inherit systemd
SYSTEMD_SERVICE_${PN} = "systemd-networkd.service"

do_install_append() {
    install -d ${D}${sysconfdir}/systemd/network/
    install -m 644 ${WORKDIR}/pcie.link ${D}${sysconfdir}/systemd/network/10-pcie.link
    install -m 644 ${WORKDIR}/pcie.network ${D}${sysconfdir}/systemd/network/20-pcie.network
}
