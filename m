From: Christopher Montgomery <xiphmont@gmail.com>
Date: Thu, 29 Jan 2009 22:33:11 +0000
Subject: Re: [lm-sensors] w83667hg support feedback: some things work,
Message-Id: <806dafc20901291433g6e1ab132t92950ee5461cb97c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <806dafc20901200009l2fd53e9bnea2e5402f17b5da2@mail.gmail.com>
In-Reply-To: <806dafc20901200009l2fd53e9bnea2e5402f17b5da2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks for reporting. Apparently the pin usage bits have inverted logic
> between the W83627EHG and the W83667HG. Can you please test the
> following patch? It should fix your problem.

I'll check tonight.

> That's more surprising. How exactly did you attempt to set sane values?
> If you edited /etc/sensors3.conf, please remember that it takes a
> "sensors -s" to write the new limits to the chip.

Ah, that was certainly my mistake.

Are somewhat scattershot defaults somewhat to be expected?

Monty

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
