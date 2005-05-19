From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Add class definition to the elektor bus driver
Message-Id: <20050225215419.GA27509@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050225211155.0d258af2.khali@linux-fr.org>
In-Reply-To: <20050225211155.0d258af2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 25, 2005 at 09:11:55PM +0100, Jean Delvare wrote:
> Hi Frank, all,
> 
> > > Which bus driver are you using? It obviously lacks class declaration,
> > > so the correct fix is to add the class there.
> >
> > The modules that are loading are (in reverse order):
> >      adm1031
> >      ad5321
> >      mic184
> >      pca9540
> >      i2c_sensor
> >      i2c_elektor
> >      i2c_algo_pcf
> >      i2c_core
> > 
> > So I believe what you are asking for is the i2c_elektor driver for the
> > PCF8584 ISA to I2C chip.
> 
> Correct, I just checked and this one actually lacks its class. Patch
> follows.
> 
> Greg, can you please apply this one to your tree?
> Thanks.
> 
> This patch adds a class definition to the elektor i2c bus driver.
> Without this definition, hardware monitoring chips located on such
> busses cannot possibly be driven.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
