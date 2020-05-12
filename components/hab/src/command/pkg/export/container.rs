use std::ffi::OsString;

use crate::common::ui::UI;

use crate::error::Result;

const EXPORT_CMD: &str = "hab-pkg-export-container";
const EXPORT_PKG_IDENT: &str = "core/hab-pkg-export-container";
const EXPORT_PKG_IDENT_ENVVAR: &str = "HAB_PKG_EXPORT_CONTAINER_PKG_IDENT";

pub async fn start(ui: &mut UI, args: &[OsString]) -> Result<()> {
    crate::command::pkg::export::export_common::start(ui,
                                                      args,
                                                      EXPORT_CMD,
                                                      EXPORT_PKG_IDENT,
                                                      EXPORT_PKG_IDENT_ENVVAR).await
}