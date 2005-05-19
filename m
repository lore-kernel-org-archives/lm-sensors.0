From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: [PATCH 2.6] it87 reset option
Message-Id: <20040301192651.GA9609@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228183508.200a8655.komoriya@paken.org>
In-Reply-To: <20040228183508.200a8655.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 01, 2004 at 10:22:59AM +0900, Takeru KOMORIYA wrote:
> Hi,
> 
> On Sat, 28 Feb 2004 18:27:58 +0100
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > First of all, the patch leaves all INIT macros untouched. They are not
> > used anywhere in the driver now, so they should go.
> 
> > No extra line here please.
> 
> Sorry for my rush patch. I should have been more careful...
> I've fixed these two issues.
> 
> How about this patch?

Thanks, I've applied this one.

greg k-h
