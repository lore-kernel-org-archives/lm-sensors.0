From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 31 May 2005 10:18:25 +0000
Subject: [lm-sensors] sensors-detect failed to see my SMbus
Message-Id: <429C1DBD.3040908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A2ABC.1040809@sh.cvut.cz>
In-Reply-To: <429A2ABC.1040809@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,


John WICKS wrote:
>    G'day Rudolf,
>    sorry about the subject, my mistake :-(
>    below are the outputs from the commands requested.
>    I would like to attempt to activate the bus as it would be handy considering
>    I work in hot environments a lot.

CPU temperature is not enough?
You have it in acpi command:

>         Thermal 1: ok, 45.0 degrees C

And on SMBUs there will be most likely nothing. I'm sure to 99.9%. But if you really want we can try, but it is your
risk that you will damage your laptop in worst case scenario.

Also in /proc/acpi you can find some files like battery etc. Maybe there are more temperatures
You can use cat /proc/acpi/something/somefile to see what is inside.

Regards

Rudolf

