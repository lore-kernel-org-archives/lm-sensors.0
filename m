From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: vt8231 and vt1211 changes
Message-Id: <4036B758.4060701@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The libsensors change is a good catch. thanks.
The masking of the uch_config register in the 8231 and 1211 driver looks good,
definitely harmless.

I implemented temp1 and in6 and later noticed that the datasheet called them reserved.
I never removed them from the driver though.

mds

Jean Delvare wrote:
> Hi Mark,
> 
> Please check and confirm my recent changes to the vt8231 and vt1211
> drivers and associated entries in libsensors. I had to help a vt1211
> user today and looking at the code these changes are obvious, but I
> don't have a data sheet not chips to test the changes, so another pair
> of eyes would be appreciated ;)
> 
> BTW, why are temp1 and in6 exported by the drivers, while they are
> advertised as not supported in the drivers, docs and config file?
> 
> Thanks.
> 
