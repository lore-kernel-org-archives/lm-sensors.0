From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Sat, 05 Dec 2009 04:59:52 +0000
Subject: Re: [lm-sensors] Drivers/motherboards with wattage & amperage
Message-Id: <C915ED79-31E0-454D-B7DC-680C194DCCA1@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0912041515o5cebdb20sb00a241df1bf5ca9@mail.gmail.com>
In-Reply-To: <9871ee5f0912041515o5cebdb20sb00a241df1bf5ca9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I haven't seen servers with per-component power sensors but Penguin  
Computing (the company I work for) just introduced the Relion 700  
"efficient compute node" for HPC clusters and it includes sensors in  
the power supply that report power used by the platform as a whole. We  
would be happy to quote you or your colleages on a turn-key cluster  
pre-wired and ready to run HPC applications.

The sensor readings are available via IPMI and we recommend ipmitool  
as a way to read those values. But there were just recent posts  
describing the ipmisensors and bmcsensors modules that will translate  
ipmi sensor readings into lm-sensors framework.

There are also PDU's available that have per-outlet power monitoring  
that will tell you how much power is being drawn by the attached  
equipment.

Phil P.

-- 
Philip Pokorny, RHCE
Chief Hardware Architect
PENGUIN COMPUTING, Inc
www.penguincomputing.com

On Dec 4, 2009, at 6:17 PM, "Timothy Normand Miller"  
<theosib@gmail.com> wrote:

> Some colleagues of mine are doing some experiments where they would
> like to monitor power and current of different system components in
> real time while running various HPC workloads.  They're willing to buy
> whatever kind of motherboards they need that provide the sensors they
> need.  They're aware that, for instance, Apple computers provide all
> these sensors, but buying a cluster of MacBook Pros would be too
> expensive.
>
> Can anyone recommend a motherboard with these sensors that are
> supported by lm_sensors?
>
> Thanks!
>
>
> -- 
> Timothy Normand Miller
> http://www.cse.ohio-state.edu/~millerti
> Open Graphics Project
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
