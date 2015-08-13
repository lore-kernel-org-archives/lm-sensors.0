From: tarqui <tarqui@aruba.it>
Date: Thu, 13 Aug 2015 06:15:16 +0000
Subject: [lm-sensors] fancontrol doesn't restart on resume from suspend or hibernation (with solution)
Message-Id: <55CC35F4.9010507@aruba.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi, i'm using debian stable (now jessie).

i solved the issue in the subject by adding this script
/lib/systemd/system-sleep/fancontrol (of course made executable with
chmod +x)

#!/bin/sh
#
# /lib/systemd/system-sleep/fancontrol
#
# restart fancontrol on resume

case "${1}" in
    pre)
        # does nothing
    ;;
    post)
        /etc/init.d/fancontrol restart
    ;;
    *) exit
    ;;
esac

--

i hope this will be merged in some next .deb package in repository.
many thanks for this little big utility.
regards.
tarqui

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
