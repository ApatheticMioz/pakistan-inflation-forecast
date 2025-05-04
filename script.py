#!/usr/bin/env python3
"""
sbp_easydata_download_dataset.py

Log into SBP EasyData, navigate to a dataset, and download the full dataset CSV
to a specified directory using headless Chrome and Selenium.
"""

import os
import time
import argparse
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

# URLs and XPaths (may need adjustment if SBP updates their UI)
LOGIN_URL       = "https://easydata.sbp.org.pk/apex/f?p=10:1:0"
DATASETS_URL    = "https://easydata.sbp.org.pk/apex/f?p=10:210:0"  # List of datasets :contentReference[oaicite:0]{index=0}

def init_driver(download_dir: str) -> webdriver.Chrome:
    """
    Initialize headless Chrome with download prefs set to download_dir.
    """
    os.makedirs(download_dir, exist_ok=True)

    chrome_opts = Options()
    # Use the new headless mode for file downloads :contentReference[oaicite:1]{index=1}
    chrome_opts.add_argument("--headless=new")
    chrome_opts.add_argument("--disable-gpu")
    prefs = {
        "download.default_directory": os.path.abspath(download_dir),
        "download.prompt_for_download": False,
        "download.directory_upgrade": True,
        "plugins.always_open_pdf_externally": True
    }
    chrome_opts.add_experimental_option("prefs", prefs)
    driver = webdriver.Chrome(options=chrome_opts)
    driver.set_page_load_timeout(30)
    return driver

def login(driver: webdriver.Chrome, username: str, password: str) -> None:
    """
    Log into EasyData using provided credentials.
    """
    driver.get(LOGIN_URL)
    time.sleep(2)  # wait for page load
    # These element locators may change; update via browser inspector if needed
    driver.find_element(By.ID,   "P101_USERNAME").send_keys(username)
    driver.find_element(By.ID,   "P101_PASSWORD").send_keys(password)
    driver.find_element(By.ID,   "B101_LOGIN").click()
    time.sleep(3)  # allow time for login redirect

def download_dataset(driver: webdriver.Chrome, dataset_id: str) -> None:
    """
    Navigate to a dataset detail page by ID and click its Download CSV button.
    dataset_id is the apex parameter for the dataset (e.g. '16' for the first item).
    """
    # Construct detail URL (flow_id and flow_step_id may need to be confirmed)
    detail_url = (
        "https://easydata.sbp.org.pk/apex/wwv_flow.show"
        "?p_flow_id=10&p_flow_step_id=220&p_instance=&p_request=DATASET"
        f"&x01={dataset_id}"
    )
    driver.get(detail_url)
    time.sleep(2)
    # Click the download button (update the locator if SBP UI changes)
    driver.find_element(By.XPATH, "//button[contains(text(),'Download CSV')]").click()
    # Wait sufficiently long for download to finish (depending on dataset size)
    time.sleep(15)

def main():
    parser = argparse.ArgumentParser(
        description="Download an SBP EasyData dataset via Selenium"
    )
    parser.add_argument("--user",     "-u", required=True, help="Your SBP EasyData username")
    parser.add_argument("--pass",     "-p", dest="password", required=True, help="Your SBP EasyData password")
    parser.add_argument("--dataset",  "-d", required=True, help="Dataset ID from the List of Datasets page")
    parser.add_argument("--outdir",   "-o", default="files", help="Directory to save downloaded CSV")
    args = parser.parse_args()

    driver = init_driver(args.outdir)
    try:
        login(driver, args.user, args.password)
        download_dataset(driver, args.dataset)
        print(f"✅ Dataset {args.dataset} download should be in: {os.path.abspath(args.outdir)}")
    finally:
        driver.quit()

if __name__ == "__main__":
    main()
