From: whitney@Math.Berkeley.EDU (Wayne Whitney)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors current CVS on 2.6.0-test10
Message-Id: <Pine.SOL.4.44.0311291052100.22352-100000@blue1>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
In-Reply-To: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 29 Nov 2003, Jean Delvare wrote:

> I could reproduce the bug and fix. It was caused by sysfs algorithm
> labels being filled statically, while the same labels are dynamically
> allocated with procfs. Calling free on the labels would crash sensors in
> the first case, of course.
>
> You can check an up-to-date version from CVS, should work :)

Yes, that does the trick!

Thanks, Wayne

