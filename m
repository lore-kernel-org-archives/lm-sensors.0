From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: [Fwd: Re: I2C drivers]
Message-Id: <3F4B8C57.50709@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(I meant to CC this to the list)

-------- Original Message --------
From: 	- Tue Aug 26 09:35:07 2003
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00800000
Message-ID: 	<3F4B8C3A.1040205@edgedesign.us>
Date: 	Tue, 26 Aug 2003 09:35:06 -0700
From: 	Philip Edelbrock <phil@edgedesign.us>
Organization: 	Edge Design
User-Agent: 	Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) 
Gecko/20030401
X-Accept-Language: 	en-us, en
MIME-Version: 	1.0
To: 	Ralf Baechle <ralf@linux-mips.org>
Subject: 	Re: I2C drivers
References: 	<20030826013427.GA32614@linux-mips.org>
In-Reply-To: 	<20030826013427.GA32614@linux-mips.org>
Content-Type: 	text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 	7bit



Hi Ralf,

Normally what happens is we get a request for an I2C_DRIVERID and we 
assign it the next number in our central list.  Linus should be using 
our constants (which I think he is).  What we should probably do is add 
your driver id's to the list and assign them the next available 
numbers.  We try to centralize this to keep things sane, especially if 
code migrates across trees (as I think you are sensing might be an issue 
down the road).  There are two groups of numbers: for lm_sensors drivers 
and others included elsewhere.  We maintain both lists.

What are the I2C_DRIVERID constants you which to add?


Phil

Ralf Baechle wrote:

>Phil,
>
>I got two I2C drivers for both 2.4 and 2.6 pending in my pile of MIPS
>patches.  There's just one little issue I'd like to checkout with you
>first.  The I2C_DRIVERID_* constants which have been used in the MIPS
>tree for these drivers have in the meantime also been assigned in
>Linus's and Marcelo's trees.  Are these constants somehow visible
>in the kernel API or can I just go re-assign the next available
>number?
>
>Thanks,
>
>  Ralf
>
>  
>

