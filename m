From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 05 Nov 2014 16:57:29 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <20141105175729.39a88ab1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 5 Nov 2014 10:57:48 +0100, Jean Delvare wrote:
> On Tue, 04 Nov 2014 10:20:42 +0100, Taz wrote:
> > Am I wrong ? Do someone have any clue or suggestion ?
> 
> Most likely the leak is in bash itself and fancontrol is only exposing
> it.
> 
> Which version of bash are you using? Try with different versions and
> see if they all behave the same.

As I can reproduce the issue, I tried it myself, and my results are as
follows:
bash 3.0.16: Memory consumption (RSS) is steady
bash 3.1.14: Memory consumption (RSS) increases
bash 4.2.53: Memory consumption (RSS) increases
bash 4.3.30: Memory consumption (RSS) increases

So apparently this is a regression introduced in bash 3.1 and not fixed
yet.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
