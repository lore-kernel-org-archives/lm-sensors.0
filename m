From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Fri, 21 Sep 2018 16:23:52 +0000
Subject: Re: How to configure my motherboard
Message-Id: <5a9e36a6-7551-5a38-70e0-15755e39987e@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
In-Reply-To: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Léo,

On 21/09/2018 16:34, Léo El Amri wrote:
> Hello there,
> 
> I would like to know how I can configure my motherboard. ie:
> How can I find relations between voltage and temperature ?

This article documents how to figure out the voltage labels and the
voltage divider ratios:
https://hwmon.wiki.kernel.org/voltagelabelsandscaling
I may be able to help with some of the voltage labels later.

The temperatures are often reported correctly already. In the cases when
the values are clearly bogus, I haven't yet figured out what the problem
can be.

> How to identify sensors "locations" ?

Which sensors? What locations?

> I guess my first "entry point" on the matter would be to read the
> datasheet of the chip.

That'll be a long read, but you'll need a couple of numbers from the
datasheet, see the article above.

> Here are some information about my MB:
> Manufacturer: ASRock
> Model: B450 Gaming-ITX/ac
> BIOS version: (AMI) P1.20
> Chip (As identified by sensors-detect): Nuvoton NCT6792D
> Chip (As identified by sensors): nct6792-isa-0290
> Driver for the sensor: nct6775
> 
> I could find the location for the datasheet at
> http://www.nuvoton.com/hq/products/cloud-computing/i-o/super-i-o-series/nct6792d/
> . However, I need an account to download it. Does someone here already
> have a "myNuvoton" account ?
> 
> I may ask more questions once I get to read the datasheet.
> 
> While I'm at it: How should I name the configuration file if ever I had
> to share it ? (The / in the model name being the problem)

Not sure, perhaps B450-Gaming-ITX-ac.conf.

Best regards
Ondřej Lysoněk
