From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Fri, 23 Mar 2012 14:07:55 +0000
Subject: [lm-sensors] labels for it87 compared to mbmon
Message-Id: <jwv1uojmn1f.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

`xmbmon' gives me 3 temperatures, called MB/CPU/chip.
`sensors' gives me three temperatures from the `it87' module and those
temperatures seem to match perfectly the ones I get from xmbmon, but
their label is just temp1/temp2/temp3.

Any reason why lm-sensors uses generic labels?


        Stefan "I don't know if MB and chip labels are correct, but the
                CPU label seems right since it's the one most
                susceptible to change under CPU load"


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
