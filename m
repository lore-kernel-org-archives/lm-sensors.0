From: Rob Herring <robh@kernel.org>
Date: Mon, 22 Feb 2016 02:53:37 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/3] ARM: dts: Change iio_hwmon nodes to use hypen in node names
Message-Id: <20160222025337.GA15973@rob-hp-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
 <c47b13603fe72737ef67ed8b90fc61516cfa2a20.1455597464.git.maitysanchayan@gmail.com>
In-Reply-To: <c47b13603fe72737ef67ed8b90fc61516cfa2a20.1455597464.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux@roeck-us.net, shawnguo@kernel.org, jdelvare@suse.com, stefan@agner.ch, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, Feb 16, 2016 at 10:30:54AM +0530, Sanchayan Maity wrote:
> Change iio_hwmon nodes to use hypen in node names instead of
> underscore.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/iio-bindings.txt | 2 +-
>  arch/arm/boot/dts/imx23.dtsi                           | 2 +-
>  arch/arm/boot/dts/imx28.dtsi                           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

No real objection here though I don't think this is really necessary. 
While we prefer '-' to '_' it's not really strong enough to change. It 
bothers me more that the node name leaks to userspace.

Rob

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
