From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: PCF8591
Message-Id: <3BFA8E5A.4FC73A05@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E165yoo-0006Us-00@localhost>
In-Reply-To: <E165yoo-0006Us-00@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
I patched it, just forgot to check it in.
fixed
mds

Aurelien Jarno wrote:
> 
> Hello
> 
> I have seen that the patch for the PCF8591 has been put in the CVS, but yet
> it doesn't compile. It seems the file kernel/include/sensors.h has not been
> patch (I don't understand why).
> So here is a new patch to correct this.
> 
> Aurelien Jarno
> 
> 
>                      Name: pcf8591.patch2
>    pcf8591.patch2    Type: text/x-diff
>                  Encoding: base64
