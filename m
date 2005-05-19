From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test7
Message-Id: <20031015191300.GA11752@mars.ravnborg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10662411473410@kroah.com> <10662411472283@kroah.com>
In-Reply-To: <10662411472283@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Wed, Oct 15, 2003 at 11:05:47AM -0700, Greg KH wrote:
> -device_create_file(&client->dev, &dev_attr_in_max##offset);
> +device_create_file(&client->dev, &dev_attr_in_max##offset); \
> +} while (0);
              ^
Did you really want to have that ';' there?
It is harmless in current usage, but it may be confusing.

	Sam
