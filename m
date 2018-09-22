From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Sat, 22 Sep 2018 10:17:49 +0000
Subject: Re: How to configure my motherboard
Message-Id: <ec335832-6bf3-7ae8-40ed-73eb0c455831@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
In-Reply-To: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 21/09/2018 18:56, Léo El Amri wrote:
> On 21/09/2018 18:23, Ondřej Lysoněk wrote:
>>> How to identify sensors "locations" ?
>>
>> Which sensors? What locations?
> 
> I used the wrong terminology. By "sensors" I meant "voltage",
> "temperature" and "pwm" (For example), and by "location" I meant "CPU",
> "Northbridge", "2nd chassis fan" (For example). So I can have a match
> such as "in1 is the 5V line", or "fan1 is the CPU fan".

The article explains how to guess some of the voltage labels. The
datasheet could help with some of the others (you'd need to compare it
with the driver code).

Regarding fans, you can try adjusting the speed of the fans using the
sysfs interface, and seeing which fan reported by 'sensors' changed its
speed and which fan physically changed its speed. Then look where on the
board the fan is connected, there should be a label near the connector,
such as SYS FAN1 or CPU FAN.

Temperatures, I don't know. That may be tough. Send the output of the
'sensors' command.

> And I'll proceed to download the datasheet by myself if nobody got it
> before I really need it.

Even is someone had it, I'm not sure they'd be allowed to share it. You
should probably ask Nuvoton yourself for it.

Ondřej Lysoněk
