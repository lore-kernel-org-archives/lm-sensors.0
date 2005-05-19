From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: driver W83784
Message-Id: <Pine.LNX.3.96.1030831141503.18453B-100000@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.3.96.1030722161727.25099C-100000@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.3.96.1030722161727.25099C-100000@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> what standards we have are in doc/developers/proc.
> the two examples you cited, we don't have standards for.

Ok thank you.

Good news. Driver works, but I have there for sensors data ram one array
called 'ram'.

Rest of values obtained from various registers are stored
in variables pwm_duty[] etc.

I guess I should remove the monolithic 'ram' array and split it into
logicaly smaller pieces. Right ?

Also I would like ask about the register adress mappings.

For example on lower reg number is stored temp2 and on next temp1.
I solved this by ordering the sysctl numbers. T2 got lower.

Is it OK or should I make some #define with mapping macro ?

Regards

Rudolf


 
