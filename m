From: =?UTF-8?Q?L=c3=a9o_El_Amri?= <leo@superlel.me>
Date: Fri, 21 Sep 2018 16:56:31 +0000
Subject: Re: How to configure my motherboard
Message-Id: <1036d8ce-b330-5fb8-c68d-bf366750aafd@superlel.me>
List-Id: <lm-sensors.vger.kernel.org>
References: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
In-Reply-To: <33304168-d348-e9c1-dc86-b017a69ec452@superlel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ondřej,

On 21/09/2018 18:23, Ondřej Lysoněk wrote:
> The temperatures are often reported correctly already. In the cases when
> the values are clearly bogus, I haven't yet figured out what the problem
> can be.

In my case, the reading for the CPU ("CPUTIN") is -62500

>> How to identify sensors "locations" ?
> 
> Which sensors? What locations?

I used the wrong terminology. By "sensors" I meant "voltage",
"temperature" and "pwm" (For example), and by "location" I meant "CPU",
"Northbridge", "2nd chassis fan" (For example). So I can have a match
such as "in1 is the 5V line", or "fan1 is the CPU fan".

I'll try the method from voltagelabelsandscaling right away.
And I'll proceed to download the datasheet by myself if nobody got it
before I really need it.

Thanks :)
Léo
