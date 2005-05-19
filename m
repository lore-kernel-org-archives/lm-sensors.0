From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I2C driver for embedded Motorola PPC products
Message-Id: <404FC13C.9060301@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
In-Reply-To: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the offer.

We've had trouble with the existing PPC drivers in our tree.
They tend not to be maintained and don't get much usage out of our tree.
The PPC mailing lists and development trees seem to be much better places to
put them.

And that was before 2.6 came along. Now it's even worse. 
You're most unlikely to get into
the official 2.4 kernel via any path, and definitely not from
a patch out of our i2c or lm_sensors tree. 2.4 is pretty much done.

So we're happy to review your driver and help you out if you need it.
But if you're looking to get the driver where people will use it,
and ultimately into the mainstream kernel, you should target
a PPC 2.6 tree.

mds



Greg KH wrote:
> On Wed, Mar 10, 2004 at 04:51:34PM -0600, Kumar Gala wrote:
> 
>>Thanks, quick question -- any significant changes in APIs between 2.4 
>>and 2.6?
> 
> 
> Heh, a few.  See the code for what they are :)
> 
> good luck,
> 
> greg k-h
> 
> 
