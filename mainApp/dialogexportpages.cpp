/****************************************************************************
**
** Copyright (C) 2015 Trevor SANDY. All rights reserved.
**
** This file may be used under the terms of the
** GNU General Public Liceense (GPL) version 3.0
** which accompanies this distribution, and is
** available at http://www.gnu.org/licenses/gpl.html
**
** This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
** WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
**
****************************************************************************/

#include "dialogexportpages.h"
#include "ui_dialogexportpages.h"

DialogExportPages::DialogExportPages(QWidget *parent) :
  QDialog(parent),
  ui(new Ui::DialogExportPages)
{
  ui->setupUi(this);

  ui->radioButtonAllPages->setChecked(true);
  ui->labelAllPages->setText(QString("1 to %1").arg(gui->maxPages));
  ui->labelCurrentPage->setText(QString("%1").arg(gui->displayPageNum));

  switch(gui->exportType){
    case EXPORT_PDF:
      setWindowTitle(tr("Print to pdf"));
      ui->groupBoxPrintOptions->setTitle("Print to pdf options");
      break;
    case EXPORT_PNG:
      setWindowTitle(tr("Export as png"));
      ui->groupBoxPrintOptions->setTitle("Export as png options");
      break;
    case EXPORT_JPG:
      setWindowTitle(tr("Export as jpg"));
      ui->groupBoxPrintOptions->setTitle("Export as jpg options");
      break;
    case EXPORT_BMP:
      setWindowTitle(tr("Export as bmp"));
      ui->groupBoxPrintOptions->setTitle("Export as bmp options");
      break;
    }
}

DialogExportPages::~DialogExportPages()
{
  delete ui;
}

QString const DialogExportPages::pageRangeText(){
  return ui->lineEditPageRange->text();
}

bool DialogExportPages::allPages(){
  return ui->radioButtonAllPages->isChecked();
}

bool DialogExportPages::currentPage(){
  return ui->radioButtonCurrentPage->isChecked();
}

bool DialogExportPages::pageRange(){
  return ui->radioButtonPageRange->isChecked();
}

