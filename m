From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: IBM x345
Message-Id: <20030319165725.GA15212@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319163745.K19708@glum.quniverse.sk>
In-Reply-To: <20030319163745.K19708@glum.quniverse.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 19, 2003 at 04:37:45PM +0100, Peter Stelmachovic wrote:
> I know that there is a RSA Adapter which can communicate with the H8 
> chip and that there are linux drivers (written  by IBM) for the
> adapter.

The IBM RSA chip does not use the sensors package, that is correct.

> But we do not have that adapter so what I am asking is if there is a
> possibility how to use the H8 chip or at least how to read the health
> status directly without the RSA Adapter.

Have you tried the sensors-detect program to see what it says?

thanks,

greg k-h
