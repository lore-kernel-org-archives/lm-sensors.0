From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 29 Nov 2011 20:39:00 +0000
Subject: Re: [lm-sensors] [f75387] modifying f75375s module
Message-Id: <71B4C45B-6A83-4FC4-8986-CE12121CD616@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
In-Reply-To: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Configuration file is case sensitive. You used F75387 with upper-case F
> in the configuration file while your chip name is f75387 with a
> lower-case f. Fix that and the configuration section will take effect.

Yes, that's it! sensors now works as expected, thanks for the hints  ;-)

..now working on the module source code to support also the origin Fintek chip f75375s again.. May I then provide the patch to you for checkup, or would the kernel list be the better way to provide it?

--
Bjoern Gerhart




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
