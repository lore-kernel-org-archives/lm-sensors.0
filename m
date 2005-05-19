From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <nn417158cje74mms51tad9rj2uq7br47kd@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,
On Wed, 27 Apr 2005 23:57:41 -0700, Greg KH <greg@kroah.com> wrote:

>
>And how would it work with the 99% of the kernel that doesn't create
>attributes dynamically on the fly?

Create an index attribute: write index value, read/write attribute 
data?  Nothing else need know, just the driver needing unbounded 
indexed attributes.

--Grant.
