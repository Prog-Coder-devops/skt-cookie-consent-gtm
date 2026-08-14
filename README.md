# SKT Cookie Consent — Google Consent Mode v2 (GTM Template)

Official Google Tag Manager consent mode template for the
[SKT Cookie Consent](https://www.sktthemes.org/shop/skt-cookie-consent/)
WordPress plugin.

This template integrates with the GTM Consent APIs to set the default consent
state on page load and update it based on the visitor's choice in the SKT Cookie
Consent banner (read from the `sktcoco_consent_mode` cookie). It supports all
Google Consent Mode v2 signals: `ad_storage`, `analytics_storage`,
`ad_user_data`, `ad_personalization`, `functionality_storage`,
`personalization_storage`, and `security_storage`.

## Usage

1. Install the template from the Community Template Gallery.
2. Create a tag from it and fire it on **Consent Initialization - All Pages**.
3. Add a second **Custom Event** trigger on `sktcoco_consent_update` to apply
   consent changes.

## License

Apache 2.0 — see [LICENSE](LICENSE).
