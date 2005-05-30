From: grant_lkml@dodo.com.au (Grant Coady)
Date: Mon, 30 May 2005 02:43:38 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <thnk911it0qeqj02ns1p1krthbvsfeu1ct@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 29 May 2005 20:18:43 -0400, Keenan Pepper <keenanpepper@gmail.com> wrote:
>
>Yes, I compiled all the drivers as modules as recommended here: 
>http://secure.netroedge.com/~lm78/kernel26.html
>
>sensors-detect says "Success... but not activated", which confuses me.

I looked at the source, and the 'disabled' message (dmesg) is thrown 
as hwmon section of the SuperIO chip appears disabled, perhaps it 
was locked by BIOS.  (I know other SuperIO chipset's can lock settings)
>
>My BIOS displays the fan speed and CPU temperature, so I know the sensors are 
>actually there, I just can't access them from linux.

If box is recent or laptop, you don't want to interfere with CPU 
cooling / clock control stuff.  Access via ACPI instead, much safer.

I know nothing of the particular driver, but we've covered the 
basics, you've provided info requested to clarify your issue, 
perhaps the driver author will chime in now :)

--Grant.

