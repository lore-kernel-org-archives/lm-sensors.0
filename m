From: oliverks@tescina.com (Oliver King-Smith)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: i2c clock running at 16Khz
Message-Id: <104B9306-6EEE-11D9-9F95-00039366B8DC@tescina.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <whqVzY37.1106583170.3507600.khali@localhost>
In-Reply-To: <whqVzY37.1106583170.3507600.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

On Jan 24, 2005, at 8:12 AM, Jean Delvare wrote:

>
> Hi Oliver,
>
>> i am running gentoo linux 2.6.10-r6 on a via EPiA-m board that uses a
>> VT835 southbridge.  when you i use the i2c bus, the clock and data
>> lines appear to be running at 16KHz not the more normal 100kHz or
>> 400KHz speeds
>
> 100kHz and 400kHz are *maximum* frequency for standard and high-speed
> *I2C* busses. What your VIA bridge really is is an SMBus, so it must 
> run
> at a speed between 10kHz and 100kHz if I remember correctly.
>
> As a matter of fact, I already measured both my VIA and Intel SMBus 
> chips
> at 16kHz, exactly like you. So I am not surprised at all by what you 
> are
> reporting.
>
> BTW, may I ask how you did measure the frequency?

I hooked an oscilloscope to the clock and data pins.
>
>> Do you have any documentation on what the registers inside the via
>> southbridge chips do, so i can try and fix this problem?  If not do,
>> you know if this is a known problem with the via chip sets?
>
> As far as I know, there is no way to change the clock for the Intel
> SMBus. I have no documentation for the VIA chips but I would suspect
> that you cannot change it there either.
>
> May I know the SMBus speed (or rather slowness) is so important to you?

The 3rd party board I am trying to use does not seem to like the slower 
clock rate.

>
> Thanks,
> --
> Jean Delvare
>
