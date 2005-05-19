From: bertrik@zonnet.nl (Bertrik Sikken)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors.conf hint
Message-Id: <3E540F1C.9070501@zonnet.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219214848.GA1084@debian>
In-Reply-To: <20030219214848.GA1084@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michele Conte - Ceu wrote:

>In the section as99127f-* I've read:
>    # does anyone know a board for which the following is correct?
>    #   compute temp2 (@*30/43)+25, (@-25)*43/30
>
>Well, with my board (ASUS A7V8X, chipset Via kt400, sensor chip ASB100) the
>row above gives correct values of CPU temperature. The default value
>(obtained using 'compute temp2 @*2.0, @/2.0') is wrong, 20C higher than
>real values.
>
>I'm using lmsensors 2.7.0 and i2c 2.7.0 (w83781d, i2c-viapro) with kernel
>2.4.20
>
How do you know what is the 'correct' temperature?
(And where does that formula originally come from?
Is it simply an empirical formula someone came up with?)

I have an A7V333 motherboard which also contains a ASB100
sensor chip. I found out that the data in register 0x17 corresponds
exactly to the temperature reported in the BIOS.
Register 0x17 is in a range undocumented by the w83781d and lm78 datasheets.
The 'regular' temperature register usually reports a higher
temperature, but strangely enough is seems to respond slower to
changes in CPU load than the register 0x17 temperature.

Regards,
Bertrik Sikken

