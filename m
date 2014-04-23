From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 15:45:53 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (lm92) Drop FSF mailing address
Message-Id: <20140423174553.45fdb3be@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397861485-31740-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397861485-31740-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Apr 2014 15:51:23 -0700, Guenter Roeck wrote:
> The FSF mailing address may change, so drop it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm92.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index 5ca8e14..7193a92 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -34,10 +34,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
>  #include <linux/module.h>

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
