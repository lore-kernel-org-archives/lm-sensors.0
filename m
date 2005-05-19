From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [RFC PATCH] I2C adm9240 driver, second round
Message-Id: <9l0q51tms7kfbi92bt9p2tepjnplq0p3lf@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10hm51pcfe9aqb87f8ki18ht3runithc0v@4ax.com>
In-Reply-To: <10hm51pcfe9aqb87f8ki18ht3runithc0v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali
On Wed, 13 Apr 2005 12:57:59 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
>> Fixed
>>	local vrm copy put back in
>
>Good.
>
>>	force default interrupt mode to get temperature alarm status
>
>Might cause problem. Have you checked whether this mode change affects
>any (physical) output of the chip? If it does, then changing the mode
>that might have been set up by the BIOS is unwise, as you have no idea
>what is wired to that output.

There was no temperature alarm status in comparator mode, so I tried 
'default interrupt' mode and it worked.  Actual interrupt pin drive 
is disabled, unless I find the chip already setup, in which case I 
still turn on default interrupt mode as it is the only way to get and 
alarm state.  This also enables temp1_max_hyst, alarm on at temp1_max, 
off at temp1_max_hyst.

intr_mask does not affect alarm state, I put the read/write accessor 
in and took it out again as useless, thought it may have been set by 
BIOS, stopping temp alarm.

>>	slow update for sensor settings (instead of update on access)
>What do you mean?

You didn't like the idea of not reading chip settings occasionally, I 
call it slow update, didn't go see what other driver called it.

You asked for it, you got it :)

>>	automatic fan clock divider now works properly :)
>
>Good.
>
>>	report out of range fan_min as zero
>
>Where "out of range" means a register value of 0, or am I missing
>something?

Two types of overange:

	fan is slow, and fan_min is set = alarm state, even when fan 
	is too slow to be measured.  

	fan_min set too low = fan speed alarm disabled, auto fan
	clock divider adjustment enabled.

Can report zero for both types as alarm state always valid, that 
seems correct behaviour to me.  I needed the state information 
before thinking of instrumenting the driver instead. :-/

>I think that reporting 0 in this case is the correct thing to do,
>especially if the chip happens to disable fan alarms when the register
>limit is set to 0. Is it the case of the ADM9240?
>
>>	sensors now reads temperature (temp1_max_hyst had wrong name)
>
>OK.
>
Since then I've added read-only fan_div accessor to keep sensors 
2.9.1 happy, auto fan clock adjust either direction when fan_min 
alarm disabled.  (Forgot I'd patched 2.9.0 to not look at fan_div)

On fresh start (chip measurement not running when driver loaded) 
I set all chip limits to extremes to disable all alarms.  The chip 
is not initialised by BIOS on my hardware.

Cheers,
Grant.
