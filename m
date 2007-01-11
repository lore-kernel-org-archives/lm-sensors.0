From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 Jan 2007 09:35:04 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <20070111103504.40eeb866.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Wed, 10 Jan 2007 23:34:50 +0100, Rudolf Marek wrote:
> > 1* We display the sensor type in "sensors". This is what we do for the
> > IT87xxF devices. When the sensor type is "disabled", the user should
> > realize that the reading is meaningless.
> > 
> > 2* We change sensors to not even display tempN if that sensor is
> > disabled. This is probably even more user-friendly.
> 
> You mean during init phase?

I mean that the sensors tool would first read temp1_type, if it's 0
skip temp1 altogether, else read and display all temp1 attributes as
before. Same for temp2 etc.

> > 3* We change the w83793 driver to not present the temperature value
> > when the sensor is disabled. A bit more difficult, but doable. There's
> > something of this kind done in the f71805f hardware monitoring driver.
> 
> Yes but we need to keep the control file for that.

Depends on how we implement it. We may decide that the BIOS must have
set the types properly, make tempN_type read-only (the f71805f driver
does that), and simply not create any file for disabled temperature
channels. Or indeed we can let the user override what the BIOS has set,
in which case we must create and delete the tempN_input files
dynamically (or change their permissions dynamically, that works too).
This second option is more complex, but seems to have your preference.
As for me, I'm fine with both, as I'm not the one writing the code ;)

-- 
Jean Delvare

