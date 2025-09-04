<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewSwitcher.ascx.cs" Inherits="Portfolio_try_1.ViewSwitcher" %>
<div id="viewSwitcher" style="padding: 0.75rem; background: rgba(102, 126, 234, 0.1); border-radius: 8px; text-align: center; font-size: 0.9rem; color: #667eea;">
    <span style="font-weight: 500;">?? <%: CurrentView %> View</span>
    <span style="margin: 0 0.5rem; color: #999;">|</span>
    <a href="<%: SwitchUrl %>" data-ajax="false" style="color: #667eea; text-decoration: none; font-weight: 500; padding: 0.25rem 0.5rem; border-radius: 4px; transition: all 0.3s ease;">
        ?? Switch to <%: AlternateView %>
    </a>
</div>

<style>
    #viewSwitcher a:hover {
        background: #667eea;
        color: white;
    }
</style>