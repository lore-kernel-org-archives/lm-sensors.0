From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: driver W83784
Message-Id: <3F5B6B2F.44DAFDAC@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.3.96.1030722161727.25099C-100000@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.3.96.1030722161727.25099C-100000@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the on-chip temp sensor be temp1.

On the ram array, it's a strange winbond convention
that calls some of the registers a ram array but not others.
It doesn't really matter to us.
You can implement the driver local storage (variables in struct
w83784_data)
any way you want. If you can have more efficient code by
putting it a big 'ram' array then why not?


Rudolf Marek wrote:
> 
> > what standards we have are in doc/developers/proc.
> > the two examples you cited, we don't have standards for.
> 
> Ok thank you.
> 
> Good news. Driver works, but I have there for sensors data ram one array
> called 'ram'.
> 
> Rest of values obtained from various registers are stored
> in variables pwm_duty[] etc.
> 
> I guess I should remove the monolithic 'ram' array and split it into
> logicaly smaller pieces. Right ?
> 
> Also I would like ask about the register adress mappings.
> 
> For example on lower reg number is stored temp2 and on next temp1.
> I solved this by ordering the sysctl numbers. T2 got lower.
> 
> Is it OK or should I make some #define with mapping macro ?
> 
> Regards
> 
> Rudolf
> 
>
