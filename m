From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <3FC51373.2080705@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I'd like the two folks with the problem (or anybody else with a
>>nforce2) try the new i2cdump in cvs to confirm.
>>if 'i2cdump 0 50' works but 'i2cdump 0 50 c' fails then the problem
>>is in the amd756 driver.
> 
> 
> Bill, Fernando, if you please could get i2cdump from CVS and give it a
> try... Thanks.
> 
> 
>>Actually, if anybody has an amd756/66/68 then they could try this too.
>>Maybe the nforce2 acts a little differently...
> 
> 
> I think you're mixing things up. The i2c-amd756 driver covers the
> nforce (1), not the nforce2. I2c-nforce2 is a different driver.
> 

oops you're right.


> 
>>Write quick doesn't have any data at all, other than the
>>single read/write bit at the end of the address byte.
> 
> 
> Interesting. So basically it is just meant to check wether someone would
> acknoledge the address or not?
> 

that's what we use it for.
In theory, you write a single bit of data.
So you could use it for a single addressible switch.

