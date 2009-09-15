From: Tim Ryan <tryan@linux.com>
Date: Tue, 15 Sep 2009 18:11:48 +0000
Subject: Re: [lm-sensors] Asus ATK0110 ACPI driver and Asus P6T Deluxe
Message-Id: <25e4d1860909151111v2dbf063dmf27ce91096c2c79@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903101417.01449.clive@vacuumtube.org.uk>
In-Reply-To: <200903101417.01449.clive@vacuumtube.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Should this driver work on the ASUS P6T SE? I load the module with no
problem, but sunning sensors only shows the output from
coretemp-isa-0000, all the cores. When I load the w83627ehf module
sensors reports all the temps, voltages and fans, but I have to use
acpi_enforce_resources=lax because of conflicts. I'd prefer the Asus
ATK0110 if I can get it to work.


Tim
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
