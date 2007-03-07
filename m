From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 07 Mar 2007 09:04:25 +0000
Subject: [lm-sensors] SMSC47m1 Error inserting and Not configured - will
Message-Id: <20070307100425.872a9e00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070227220412.7D6195920@mta-fe.casema.nl>
In-Reply-To: <20070227220412.7D6195920@mta-fe.casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan,

> Honestly speaking I have no other reference (e.g. Windows) than this
> installation to see what the chip is capable of reporting.

Do you see any hardware monitoring information in the BIOS setup
screen? If not, this is usually a good indication that there is no
monitoring chip.

> I'm assuming that, besides FAN-speeds, it also monitors and reports voltage
> levels, etc... But I couldn't find any datasheet to support those thoughts.

No, this particular SMSC chip can only do fan speed monitoring and
control.

> So probably that leaves me with a motherboard of which I cannot monitor
> anything... Or do you have any other suggestions to get readings of, let's
> say CPU core temperature, etc...

If a recent version of sensors-detect didn't find any other sensor
device, indeed it looks like you can't monitor anything.

You may try ACPI (kernel modules "fan" and "thermal") instead though.

-- 
Jean Delvare

