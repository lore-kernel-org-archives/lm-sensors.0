From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Sep 2013 12:07:53 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect : Fixing use of uninitialised value 'vendor_id' on ppc64
Message-Id: <20130911140753.4eabd461@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1301926956.10694212.1378813074661.JavaMail.root@redhat.com>
In-Reply-To: <1301926956.10694212.1378813074661.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jaromir,

On Tue, 10 Sep 2013 07:37:54 -0400 (EDT), Jaromir Capik wrote:
> There's no vendor_id entry in the /proc/cpuinfo file in case of PPC64
> systems and consequently the script returns 3 screens full of the
> following errors:
> 
> Use of uninitialized value in string eq at /usr/sbin/sensors-detect line 6444
> Use of uninitialized value in string eq at /usr/sbin/sensors-detect line 6459
> Use of uninitialized value in string eq at /usr/sbin/sensors-detect line 6473
> 
> The attached patch fixes that.
> 
> Please, merge.

Thanks for reporting. I don't think sensors-detect is terribly useful
on PPC64, but the fix is simple enough so can can take it. I have
committed a slightly different variant:
  http://www.lm-sensors.org/changeset/6196

Thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
