From: =?UTF-8?Q?L=c3=a9o_El_Amri?= <leo@superlel.me>
Date: Sat, 22 Sep 2018 12:07:24 +0000
Subject: Re: How to configure my motherboard
Message-Id: <4bf35148-f8a3-971d-ba84-e9621abbda9e@superlel.me>
List-Id: <lm-sensors.vger.kernel.org>
References: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
In-Reply-To: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ondřej,

On 22/09/2018 12:17, Ondřej Lysoněk wrote:
> Regarding fans, you can try adjusting the speed of the fans using the
> sysfs interface, and seeing which fan reported by 'sensors' changed its
> speed and which fan physically changed its speed. Then look where on the
> board the fan is connected, there should be a label near the connector,
> such as SYS FAN1 or CPU FAN.

I used a more brutal method: I slowed down the fans by hand

> Temperatures, I don't know. That may be tough. Send the output of the
> 'sensors' command

With some guessing (And brutal methods again), I think I managed to find
the two temperatures shown on the BIOS. Yet, there is a ~5 degrees
Celsius difference between what the BIOS and the kernel are showing.

Here is the output of sensors:

leo@eggplant ~ $ sensors -u nct6792-isa-0290
nct6792-isa-0290
Adapter: ISA adapter
SYSTIN:
  temp1_input: 118.000
  temp1_max: 0.000
  temp1_max_hyst: 0.000
  temp1_type: 4.000
  temp1_offset: 0.000
CPUTIN:
  temp2_input: -62.500
  temp2_max: 80.000
  temp2_max_hyst: 75.000
  temp2_alarm: 0.000
  temp2_type: 4.000
  temp2_offset: 0.000
  temp2_beep: 0.000
AUXTIN0:
  temp3_input: 37.000
  temp3_max: 0.000
  temp3_max_hyst: 0.000
  temp3_alarm: 1.000
  temp3_type: 4.000
  temp3_offset: 0.000
  temp3_beep: 0.000
AUXTIN1:
  temp4_input: 107.000
  temp4_type: 4.000
  temp4_offset: 0.000
AUXTIN2:
  temp5_input: 108.000
  temp5_type: 4.000
  temp5_offset: 0.000
AUXTIN3:
  temp6_input: -128.000
  temp6_type: 4.000
  temp6_offset: 0.000
SMBUSMASTER 0:
  temp7_input: 28.500
PCH_CHIP_CPU_MAX_TEMP:
  temp8_input: 0.000
PCH_CHIP_TEMP:
  temp9_input: 0.000
PCH_CPU_TEMP:
  temp10_input: 0.000

I guessed temp7 is the CPU and temp3 is the MB.
My methodology here was to put the CPU under heavy load to make it hot,
while monitoring the temperatures returned by all the temp*_input. I
made a little Python script which was calling sensors every seconds. I
could draw a chart via LibreOffice. I can give you the files if you
want, but I wonder what are the rules and the best practices here
regarding attachments and file sharing.

You can find a draft of the config file I came up with here:
https://github.com/lel-amri/lm-sensors/blob/asrock_b450_itx/configs/ASRock/B450-Gaming-ITX-ac.conf

>> And I'll proceed to download the datasheet by myself if nobody got it
>> before I really need it.
> 
> Even is someone had it, I'm not sure they'd be allowed to share it. You
> should probably ask Nuvoton yourself for it.

How should I ask for the data sheet without freaking them out ? (This is
the first time I should have to ask for a data sheet to the manufacturer)

I am still struggling with the voltages. With the method from the wiki,
I get nearly the same values from the +3V line and the +12V line. And
only one output from sensors seems to match this one. For the +5V line
it's still a mystery.

Thanks,
Léo
