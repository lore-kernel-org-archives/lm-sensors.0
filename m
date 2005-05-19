From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: I2C parallel port adapters drivers
Message-Id: <20031114011154.GJ16352@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031102132342.79920c6f.khali@linux-fr.org>
In-Reply-To: <20031102132342.79920c6f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Simon Vogl <simon@voxel.at>, Daniel Smolik <marvin@sitour.cz>

On Sun, Nov 02, 2003 at 01:23:42PM +0100, Jean Delvare wrote:
> 
> I think we should merge the four drivers into a single one, or at least
> (if there is one good reason to access the parallel port using two
> different methods) the last three drivers into a single one. I volunteer
> to do so, but I want to ear opinions about the idea before going on.

Sounds like a good idea.

greg k-h
