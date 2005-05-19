From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [NEW PATCH] Restore compatibility with 2.4 kernels
Message-Id: <20050309205645.GA30109@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050309174933.GA9881@bode.aurel32.net>
In-Reply-To: <20050309174933.GA9881@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 09, 2005 at 06:49:33PM +0100, Aurelien Jarno wrote:
> We also seen that i2c_client is never initialized to 0, even in the 2.4
> kernels, so Jean proposed to only add the variable for compatibility
> reasons, without affecting it.

As Jean just said me, this is not the right variable. You should read 
client_count. Sorry!


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
