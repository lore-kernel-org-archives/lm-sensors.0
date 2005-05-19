From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <427FF7F2.1080802@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yani Ioannou wrote:
> On 5/9/05, Mark Studebaker <mds@mds.gotdns.com> wrote:
> 
>>2.4 bmcsensors doesn't have write support at all.
>>In fact I didn't realize that 2.6 _did_ have write support.
>>Nice Yani!
>>That is obviously a requirement for setting anything.
> 
> 
> Well I added it for setting max/min/hysteresis limits when porting the
> driver but I couldn't actually test it (my bmc doesn't offer any write
> support) .. so..err I'm surprised if it works :-). I haven't heard
> about it one way or the other from anyone yet.
> 

IIRC that's the way my HP system was too, everything was read-only.
If writes were allowed I would have written the code :(


