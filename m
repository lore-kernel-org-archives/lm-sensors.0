From: gcoady@gmail.com (Grant Coady)
Date: Thu, 03 Nov 2005 16:02:06 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <436A262D.5080509@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Sebastian,
> 
> On 2005-11-02, Sebastian Nowozin wrote:
> 
>>I just installed an EPOX ES300 miniMe barebone with a EP-4PGF mainboard
>>using Debian/testing, kernel 2.6.14.  The chip label on the board reads
>>"Winbond W83627HF-AW", and sensors-detect finds it as such with a
>>confidence of 8 at the ISA bus.
> 
...
> Yes, this is the most probable. It is always a bit frustrating to know
> that the chip could do it, but the motherboard manufacturer did not wire
> it properly to do so. Unfortunately, this is a rather common situation.
> 

I have similar sensor chip in one box (w83697hf), no fan speed control,
turns out desktop AMD Sempron doesn't have CPU power idle therefore CPU
temp varies only a couple degrees on load --> no point having fan speed
control, thus mobo make didn't wire it.  If CPU is running at ~50'C there's
not much fan speed reduction can be done, in my situation I put the PC
box under the desk to reduce the fan noise :o)

Grant.
