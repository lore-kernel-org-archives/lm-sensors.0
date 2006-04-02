From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 02 Apr 2006 10:09:27 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <442FA2D7.5080501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Rudolf,
> 
> Okay, thanks for the reply! I just moved but I have my computer
> intact. :-) So let's go with the steps you proposed. (My email isn't
> completely set up, so I'm pasting it in)
> 
>> 1) I will document that we have 0 for DC and 1 for PWM (patch to kernel doc)
>> 2) You will send me the patch on the top of that one from 23.3 that
>> fixes the DC 0 and PWM 1 plus the manual stuff, optionaly you may
>> include the new RPM cruise files features. This can be done in one
>> patch because it is just "our" internal step. When we are done with
>> this I will post the final patch and submit it to Jean for inclusion
>> 3) Now you can send the cleanup patch on the top of previous patch
>> (With the Signed-off-by stuff)
> 
> I'm ready to go, but can I send you a patch from the w83627ehf.c that
> you sent me? That's the first one that I understood. (I'm learning
> about git and how lm-sensors sends patches upstream.)

You need the file I sent to you plus the fancrt patch on the top of it. This will create
the file with all alarms voltages EHF driver, then when fancrt is applied you have the
current base to start on it.

Do your changes and when done just diff to same file but with your changes (so simply the ehf driver that I sent to you plus the fancrt patch)

> I'll send a patch that has these things:
> 1. switch DC 0 PWM 1
> 2. new RPM cruise modes

Good that is what I want to see.

> I didn't get what you wanted with the whitespace changes...

Now you get it ;)  We cannot mix more stuff together. The patch should either add features/modify or do the cleanup.


Regards
Rudolf

