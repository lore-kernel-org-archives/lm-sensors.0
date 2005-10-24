From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 24 Oct 2005 10:50:11 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <VDns7Z2r.1130143109.5544880.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

> It looks like it works.
>
> There are some informations from my system:
>
> [root@home /]# i2cdetect -l
> i2c-0   unknown         SMBus I801 adapter at 0400

Rudolf:
Maybe it would be wise to have a different name string for the ATI
variants? Like the i2c-amd756 driver does.

You'll also need to update sensors-detect with the proper "match"
entry for these devices, so that the script can suggest i2c-i801 as the
bus driver.

> Probing for `SMSC LPC47M15x or LPC47M192'... Success!
>     (confidence 6, driver `to-be-written')

There is a driver being developed for this but I think it ain't ready
yet.

> Client found at address 0x2f

Pavel:
I wonder what is there. Can you please do:

i2cdump 0 0x2f b

--
Jean Delvare
