From: "Artem S. Tashkinov" <t.artem@lycos.com>
Date: Fri, 15 Feb 2013 09:47:19 +0000
Subject: [lm-sensors] Asus P8P67 Pro configuration (for wiki)
Message-Id: <1268999849.63442.1360921639457.JavaMail.mail@webmail07>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Here's my Asus P8P67 Pro lm-sensors configuration (I couldn't create a wiki page):

chip "nct6776-*"
    label temp1 "MB"
    set temp1_max 50
    set temp1_max_hyst 40

    ignore temp2

    label temp3 "CPU"

    label in0 "Vcore"
    set in0_min 0.75
    set in0_max 1.35

    label in2 "AVCC"
    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.1

    label in3 "+3.3V"
    set in3_min  3.3 * 0.95
    set in3_max  3.3 * 1.1

    label in7 "3VSB"
    set in7_min  3.3 * 0.95
    set in7_max  3.3 * 1.1


Best regards,

Artem

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
