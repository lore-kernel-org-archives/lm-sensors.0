From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: [Fwd: Re: I2C drivers]
Message-Id: <3F609F88.4000907@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F4B8C57.50709@edgedesign.us>
In-Reply-To: <3F4B8C57.50709@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Would anybody mind allocating Ralf a couple ID's?  Thanks!


Phil

-------- Original Message --------
From: 	- Thu Sep 11 09:10:56 2003
X-UIDL: 	91ece1abb4709fb9
X-Mozilla-Status: 	0011
X-Mozilla-Status2: 	00000000
Return-Path: 	<ralf@linux-mips.org>
Received: 	from dea.linux-mips.net (p508B58B4.dip.t-dialin.net 
[80.139.88.180]) by Ren.netroedge.com (8.12.8p1/8.12.8) with ESMTP id 
h8BEvcIP004800 for <phil@edgedesign.us>; Thu, 11 Sep 2003 07:57:40 -0700
Received: 	from dea.linux-mips.net (localhost [127.0.0.1]) by 
dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8BF8iLT016983 for 
<phil@edgedesign.us>; Thu, 11 Sep 2003 17:08:44 +0200
Received: 	(from ralf@localhost) by dea.linux-mips.net 
(8.12.8/8.12.8/Submit) id h8BF8hiJ016982 for phil@edgedesign.us; Thu, 11 
Sep 2003 17:08:43 +0200
Date: 	Thu, 11 Sep 2003 17:08:43 +0200
From: 	Ralf Baechle <ralf@linux-mips.org>
To: 	Philip Edelbrock <phil@edgedesign.us>
Subject: 	Re: I2C drivers
Message-ID: 	<20030911150843.GA11197@linux-mips.org>
References: 	<20030826013427.GA32614@linux-mips.org> 
<3F4B8C3A.1040205@edgedesign.us>
Mime-Version: 	1.0
Content-Type: 	text/plain; charset=us-ascii
Content-Disposition: 	inline
In-Reply-To: 	<3F4B8C3A.1040205@edgedesign.us>
User-Agent: 	Mutt/1.4.1i
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	ham; 0.00



On Tue, Aug 26, 2003 at 09:35:06AM -0700, Philip Edelbrock wrote:

> Normally what happens is we get a request for an I2C_DRIVERID and we 
> assign it the next number in our central list.  Linus should be using 
> our constants (which I think he is).  What we should probably do is add 
> your driver id's to the list and assign them the next available 
> numbers.  We try to centralize this to keep things sane, especially if 
> code migrates across trees (as I think you are sensing might be an issue 
> down the road).  There are two groups of numbers: for lm_sensors drivers 
> and others included elsewhere.  We maintain both lists.
> 
> What are the I2C_DRIVERID constants you which to add?

The two new driver IDs are:

#define I2C_DRIVERID_MAX1617    56     /* temp sensor                   */
#define I2C_DRIVERID_SAA7191   57      /* video encoder                */
#define I2C_DRIVERID_INDYCAM   50      /* SGI IndyCam                  */

Also two new algorithms:

#define I2C_ALGO_SIBYTE	0x150000	/* Broadcom SiByte SOCs         */
#define I2C_ALGO_SGI	0x160000	/* SGI algorithm                */

I need an ID for both 2.4 and 2.6 but I assume you keep those numbers in
sync anyway?  The numbers above are what I'm currently using.

Thanks,

  Ralf


