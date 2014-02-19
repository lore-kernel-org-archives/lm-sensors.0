From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 13:52:54 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392817974.56473.YahooMailNeo@web160506.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 9:10 PM, Jean Delvare <jdelvare@suse.de> wrote:

>
> It turns out that a very frequent pair of scaling resistors is 10 Ohm
> and 56 Ohm, which leads to:
> 
> compute in6 @*(1+56/10), @/(1+56/10)
> 
> This maps your raw reading (1.896) to exactly 12.513 which is one of
> the values you saw in the BIOS, and also maps integer register values
> to 12.091 and 12.460.
> 

Ah, I see. Thank you for that input. Now it maps exactly with the BIOS values that I have observed.

> You must have changed the wrong file, or the wrong section in the right
> file. It should work.
>

Yes, it works now.

I'm almost ready with my configuration. Now here's my +5V scaling computation:

+5V BIOS samples: 5.040, 5.064, 5.136

5.064 - 5.040 = 0.024
5.136 - 5.064 = 0.072

5.136 / (24/8) = 1.712

1.712 is close enough to in5 (1.688). So my compute statement is:

compute in5 @*3, @/3

Apparently, the scaling factor I use above maps exactly with the BIOS values I have seen. So if everything checks out and you concur with my computation, then I can send in my configuration.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
