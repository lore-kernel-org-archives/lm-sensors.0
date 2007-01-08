From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 08 Jan 2007 14:16:08 +0000
Subject: [lm-sensors] kernel patch for adm1029 support
Message-Id: <20070108151608.70968e67.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <459FFAC8.40306@geomatys.fr>
In-Reply-To: <459FFAC8.40306@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Corentin,

On Sat, 06 Jan 2007 20:38:48 +0100, corentin.labbe wrote:
> Hello
> 
> This is my patchs for adding ADM1029 support in kernel.

Once again I had to edit the patch by hand before I was able to apply
it. Either it wasn't properly generated in the first place, or your
mailer is trashing it. Please test next time.

It also lacks your Signed-off-by line, as described in
Documentation/SubmittingPatches, section 11. This is mandatory.

Other than that, I am fine with your code, with the exception of minor
whitespace problems, which I can fix myself as I submit the patch
upstream. Thanks for your contribution!

-- 
Jean Delvare

